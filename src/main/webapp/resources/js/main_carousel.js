let currentIndex = 1; // 시작 인덱스 변경
const totalSlides = 3;
const slideInterval = 3000;
let slideTimer;

function showSlide(index) {
	const imageCarousel = document.querySelector('.image-carousel');
	const imageSection = document.querySelector('.image-section');
	const imageWrapper = document.querySelectorAll('.image-wrapper');

	const imageWidth = imageWrapper[0].offsetWidth + 80;

	if (index === 0) {
		index = totalSlides;
	} else if (index === totalSlides + 1) {
		index = 1;
	}

	imageCarousel.style.transition = "transform 0.5s ease-in-out";
	imageCarousel.style.transform = `translateX(-${index * imageWidth}px)`;

	currentIndex = index;
	updateIndicators();

	// 무한 루프 추가
	if (index === totalSlides + 1) {
		setTimeout(() => {
			imageCarousel.style.transition = "none";
			imageCarousel.style.transform = `translateX(-${imageWidth}px)`;
		}, 500);
		currentIndex = 1;
	} else if (index === 0) {
		setTimeout(() => {
			imageCarousel.style.transition = "none";
			imageCarousel.style.transform = `translateX(-${totalSlides * imageWidth}px)`;
		}, 500);
		currentIndex = totalSlides;
	}
}

function nextSlide() {
	showSlide(currentIndex + 1);
	resetSlideTimer();
}

function prevSlide() {
	showSlide(currentIndex - 1);
	resetSlideTimer();
}

function currentSlide(index) {
	showSlide(index + 1);
	resetSlideTimer();
}

function resetSlideTimer() {
	clearInterval(slideTimer);
	slideTimer = setInterval(() => {
		nextSlide();
	}, slideInterval);
}

function updateIndicators() {
	const indicators = document.querySelectorAll('.carousel-indicator');
	indicators.forEach((indicator, index) => {
		if (index + 1 === currentIndex) {
			indicator.classList.add('active-indicator');
		} else {
			indicator.classList.remove('active-indicator');
		}
	});
}

// Start auto-slide
resetSlideTimer();