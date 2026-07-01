// ==UserScript==
// @name YT_Ad_Remover
// @description Remove Ads from YouTube
// @include http*://*.youtube.com/*
// @include http*://youtube.com/*
// @include http*://*.youtu.be/*
// @include http*://youtu.be/*
// ==/UserScript==

let url = location.href;
// Initial Load
window.addEventListener("load", ytRoutine, true);

// Restart on Route Change
document.body.addEventListener("click", setUrl_StartRoutine, true); // In app Change
window.addEventListener("popstate", setUrl_StartRoutine, true); // Browser History Change

function setUrl_StartRoutine() {
    if (url !== location.href) {
        url = location.href;
        ytRoutine();
    }
}

let prevClear;

function ytRoutine() {
    if (typeof prevClear === "function") {
        prevClear();
    }
    prevClear = clearAfterAMinute(() => {
        removeMast_StatementAds();
        removeAdBanners();
        removeVideoAdBanner();
        skipVideoAd();
    });
    enableTheaterMode();
}

function clearAfterAMinute(cb) {
    let start = Date.now();
    const clear = () => clearInterval(intervalId);
    const intervalId = setInterval(() => {
        cb();
        // Clear after 1 Minute
        if (Date.now() - start >= 60000) clear();
    }, 200);
    return clear;
}

function skipVideoAd() {
    const adVideoPlayer = document.querySelector(
        ".ad-showing video.video-stream.html5-main-video",
    );
    if (adVideoPlayer) {
        adVideoPlayer.currentTime = adVideoPlayer.duration;
    }
}

function removeVideoAdBanner() {
    const videoAdBanner = document.querySelector(".video-ads.ytp-ad-module");
    if (videoAdBanner) {
        videoAdBanner.remove();
    }
}

function removeMast_StatementAds() {
    const mastHeadAd = document.querySelector("#masthead-ad");
    if (mastHeadAd) {
        mastHeadAd.remove();
    }
    const statementAd = document.querySelector("ytd-statement-banner-renderer");
    if (statementAd) {
        statementAd.remove();
    }
}

function removeAdBanners() {
    const adBanners = document.querySelectorAll("ytd-ad-slot-renderer");
    if (adBanners.length > 0) {
        adBanners?.forEach((banner) => {
            const parent = banner.parentElement;
            banner.remove();
            const div = `<div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;"><span>Ad Removed</span></div>`;
            parent.innerHTML = div;
        });
    }
}

function enableTheaterMode() {
    const theaterButton = document.querySelector("button[aria-keyshortcuts=t]");
    if (theaterButton) {
        theaterButton.click();
    }
}

