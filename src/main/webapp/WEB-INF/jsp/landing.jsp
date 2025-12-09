<%--
    JSP page for Sahaayata - Health & Fitness landing page.
    This content is a direct conversion from landing.html.
--%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Sahaayata - Health & Fitness</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
    <link
            href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;900&display=swap"
            rel="stylesheet"
    />
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#607AFB",
                        "background-light": "#f5f6f8",
                        "background-dark": "#0f1323",
                    },
                    fontFamily: { display: "Work Sans" },
                    borderRadius: {
                        DEFAULT: "0.25rem",
                        lg: "0.5rem",
                        xl: "0.75rem",
                        full: "9999px",
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-background-light dark:bg-background-dark font-display">
<div class="relative flex min-h-screen w-full flex-col overflow-x-hidden">
    <header
            class="sticky top-0 z-50 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-sm"
    >
        <div
                class="container mx-auto flex items-center justify-between whitespace-nowrap px-4 py-3 sm:px-6 lg:px-8"
        >
            <div class="flex items-center gap-2">
                <svg
                        class="h-6 w-6 text-primary"
                        fill="none"
                        viewbox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                >
                    <path
                            d="M12 2L3 7V17L12 22L21 17V7L12 2Z"
                            stroke="currentColor"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                    ></path>
                    <path
                            d="M3 7L12 12L21 7"
                            stroke="currentColor"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                    ></path>
                    <path
                            d="M12 22V12"
                            stroke="currentColor"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                    ></path>
                </svg>
                <h2
                        class="text-xl font-bold tracking-tight text-background-dark dark:text-background-light"
                >
                    Sahaayata
                </h2>
            </div>
            <nav class="hidden items-center gap-6 md:flex">
                <a
                        class="text-sm font-medium text-background-dark/80 dark:text-background-light/80 hover:text-primary transition-colors"
                        href="#"
                >Home</a
                >
                <a
                        class="text-sm font-medium text-background-dark/80 dark:text-background-light/80 hover:text-primary transition-colors"
                        href="#"
                >Features</a
                >
                <a
                        class="text-sm font-medium text-background-dark/80 dark:text-background-light/80 hover:text-primary transition-colors"
                        href="#"
                >Support</a
                >
            </nav>
            <div class="flex items-center gap-2">
                <a
                        class="flex h-9 items-center justify-center rounded-lg px-4 text-sm font-semibold text-background-dark dark:text-background-light bg-primary/20 dark:bg-primary/30 hover:bg-primary/30 dark:hover:bg-primary/40 transition-colors"
                        href="/login"
                >
                    Login
                </a>
                <a
                        class="flex h-9 items-center justify-center rounded-lg bg-primary px-4 text-sm font-semibold text-white hover:opacity-90 transition-opacity"
                        href="/register"
                >
                    Register
                </a>
            </div>
        </div>
    </header>
    <main class="flex-grow">
        <section class="py-16 md:py-24 lg:py-32">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid grid-cols-1 items-center gap-12 lg:grid-cols-2">
                    <div class="flex flex-col gap-6 text-center lg:text-left">
                        <h1
                                class="text-4xl font-black tracking-tighter text-background-dark dark:text-background-light sm:text-5xl md:text-6xl"
                        >
                            Achieve Your Health Goals with
                            <span class="text-primary">Sahaayata</span>
                        </h1>
                        <p
                                class="max-w-xl mx-auto lg:mx-0 text-base text-background-dark/70 dark:text-background-light/70 sm:text-lg"
                        >
                            Track your diet, fitness, and overall well-being with our
                            intuitive app. Join thousands of users who are transforming
                            their lives.
                        </p>
                        <div
                                class="flex flex-wrap justify-center gap-4 lg:justify-start"
                        >
                            <a
                                    class="flex h-12 items-center justify-center rounded-lg bg-primary px-8 text-base font-semibold text-white shadow-lg shadow-primary/20 hover:opacity-90 transition-all duration-300"
                                    href="#"
                            >
                                Get Started
                            </a>
                            <a
                                    class="flex h-12 items-center justify-center rounded-lg border border-primary/40 bg-transparent px-8 text-base font-semibold text-primary hover:bg-primary/10 transition-colors"
                                    href="#"
                            >
                                Learn More
                            </a>
                        </div>
                    </div>
                    <div
                            class="relative h-80 w-full rounded-xl shadow-2xl shadow-primary/10 lg:h-full"
                    >
                        <div
                                class="absolute inset-0 rounded-xl bg-cover bg-center"
                                style="
                    background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuD3EnH8cG_LVkB_uvGjVz5r8fjDoynyY2IiMnwG5P1hFUjps1NvuM3XwmoJ5NUcal-c9Z30XD8dvvfHJte-pkO23BpSqEvQOqHirCo1-RwIWyWrgcyE2h8BAaTY_zlyQD90Aa6FPThFgVUuZ_i3a95f1PAuGfrEr4eUKgzpxpeRO6xTx03rMciwziKN1rYSGrgTRCFgVzurRDQ7wtComWxnw_cohbc3L3HZzblj49uoDDFeciDdF1xQJWohjRhbXyzuyiy00JLJGpmy');
                  "
                        ></div>
                        <div
                                class="absolute inset-0 rounded-xl bg-gradient-to-t from-background-light dark:from-background-dark to-transparent"
                        ></div>
                    </div>
                </div>
            </div>
        </section>
        <section
                class="py-16 md:py-24 bg-background-light/50 dark:bg-background-dark/50"
        >
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="mx-auto max-w-3xl text-center">
                    <h2
                            class="text-3xl font-bold tracking-tight text-background-dark dark:text-background-light sm:text-4xl"
                    >
                        Comprehensive Feature Suite
                    </h2>
                    <p
                            class="mt-4 text-lg text-background-dark/70 dark:text-background-light/70"
                    >
                        Sahaayata offers a complete set of tools to help you stay on
                        track and achieve your health and fitness objectives.
                    </p>
                </div>
                <div
                        class="mt-12 grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3"
                >
                    <div
                            class="flex flex-col gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark/50 p-6 shadow-sm hover:shadow-primary/10 transition-shadow"
                    >
                        <div
                                class="flex h-12 w-12 items-center justify-center rounded-lg bg-primary/20 text-primary"
                        >
                            <svg
                                    fill="currentColor"
                                    height="28"
                                    viewbox="0 0 256 256"
                                    width="28"
                                    xmlns="http://www.w3.org/2000/svg"
                            >
                                <path
                                        d="M128,216S28,160,28,92A52,52,0,0,1,80,40c28.91,0,49.33,20.28,52,24,2.67-3.72,23.09-24,52-24a52,52,0,0,1,52,52C228,160,128,216,128,216Zm-4-25.55c10.49-7.3,80-55.23,80-102.45a36,36,0,0,0-36-36c-19.45,0-35.78,10.36-42.6,27a8,8,0,0,1-14.8,0C100.58,54.36,84.25,44,64,44a36,36,0,0,0-36,36c0,47.22,69.51,95.15,80,102.45A8,8,0,0,1,124,190.45Z"
                                ></path>
                            </svg>
                        </div>
                        <h3
                                class="text-xl font-semibold text-background-dark dark:text-background-light"
                        >
                            Personalized Tracking
                        </h3>
                        <p
                                class="text-background-dark/70 dark:text-background-light/70"
                        >
                            Monitor your progress with detailed insights and personalized
                            recommendations for your journey.
                        </p>
                    </div>
                    <div
                            class="flex flex-col gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark/50 p-6 shadow-sm hover:shadow-primary/10 transition-shadow"
                    >
                        <div
                                class="flex h-12 w-12 items-center justify-center rounded-lg bg-primary/20 text-primary"
                        >
                            <svg
                                    fill="currentColor"
                                    height="28"
                                    viewbox="0 0 256 256"
                                    width="28"
                                    xmlns="http://www.w3.org/2000/svg"
                            >
                                <path
                                        d="M228,115.17a32.22,32.22,0,0,0-15.68-27.53l-80-46.19a32,32,0,0,0-32.64,0l-80,46.19A32,32,0,0,0,36,142.66V192a16,16,0,0,0,16,16H204a16,16,0,0,0,16-16v-49.34A32.22,32.22,0,0,0,228,115.17ZM204,192H52V142.66a16,16,0,0,1,8.32-13.76L140.32,72.71a16,16,0,0,1,16.32,0L204,115.17V192Zm-76-24a16,16,0,0,1-16,16H100a16,16,0,0,1-16-16V136a16,16,0,0,1,16-16h12a16,16,0,0,1,16,16Zm48-16a8,8,0,0,1-8,8H156a8,8,0,0,1-8-8v-8a8,8,0,0,1,8-8h24a8,8,0,0,1,8,8Z"
                                ></path>
                            </svg>
                        </div>
                        <h3
                                class="text-xl font-semibold text-background-dark dark:text-background-light"
                        >
                            Diet & Nutrition
                        </h3>
                        <p
                                class="text-background-dark/70 dark:text-background-light/70"
                        >
                            Log your meals, track calories, and discover healthy recipes
                            tailored to your dietary needs and goals.
                        </p>
                    </div>
                    <div
                            class="flex flex-col gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark/50 p-6 shadow-sm hover:shadow-primary/10 transition-shadow"
                    >
                        <div
                                class="flex h-12 w-12 items-center justify-center rounded-lg bg-primary/20 text-primary"
                        >
                            <svg
                                    fill="currentColor"
                                    height="28"
                                    viewbox="0 0 256 256"
                                    width="28"
                                    xmlns="http://www.w3.org/2000/svg"
                            >
                                <path
                                        d="M247.31,124.69l-32-32A8,8,0,0,0,208,96H160V48a8,8,0,0,0-8-8H104a8,8,0,0,0-8,8v48H48a8,8,0,0,0-5.66,13.66l32,32A8,8,0,0,0,80,160h48v48a8,8,0,0,0,8,8h48a8,8,0,0,0,8-8V160h48a8,8,0,0,0,5.31-13.31ZM168,152h35.31L176,124.69V152Zm-16-16h-32V104h32v32Zm-48-24.69V104h35.31L112,131.31ZM104,48h48v48h-48V48Zm0,112H72.69L100,132.69V160Zm80,40H112V168h72v32Z"
                                ></path>
                            </svg>
                        </div>
                        <h3
                                class="text-xl font-semibold text-background-dark dark:text-background-light"
                        >
                            Fitness Plans
                        </h3>
                        <p
                                class="text-background-dark/70 dark:text-background-light/70"
                        >
                            Access a variety of workout routines and fitness plans
                            designed by experts for all levels of experience.
                        </p>
                    </div>
                </div>
            </div>
        </section>
        <section class="py-16 md:py-24">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div
                        class="relative overflow-hidden rounded-xl bg-primary/10 dark:bg-primary/20 p-8 sm:p-12"
                >
                    <div
                            class="absolute -top-10 -right-10 h-32 w-32 rounded-full bg-primary/20"
                    ></div>
                    <div
                            class="absolute -bottom-12 -left-12 h-48 w-48 rounded-full bg-primary/20"
                    ></div>
                    <div class="relative text-center">
                        <h2
                                class="text-3xl font-bold tracking-tight text-background-dark dark:text-background-light sm:text-4xl"
                        >
                            Ready to Begin Your Health Journey?
                        </h2>
                        <p
                                class="mt-4 text-lg text-background-dark/70 dark:text-background-light/70"
                        >
                            Sign up today and take the first step towards a healthier,
                            stronger, and happier you.
                        </p>
                        <div class="mt-8">
                            <a
                                    class="inline-flex h-12 items-center justify-center rounded-lg bg-primary px-8 text-base font-semibold text-white shadow-lg shadow-primary/20 hover:opacity-90 transition-all duration-300"
                                    href="#"
                            >
                                Create Your Free Account
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <footer class="bg-background-light/50 dark:bg-background-dark/50">
        <div class="container mx-auto px-4 py-8 sm:px-6 lg:px-8">
            <div
                    class="flex flex-col items-center justify-between gap-4 md:flex-row"
            >
                <div class="flex items-center gap-2">
                    <svg
                            class="h-5 w-5 text-primary"
                            fill="none"
                            viewbox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg"
                    >
                        <path
                                d="M12 2L3 7V17L12 22L21 17V7L12 2Z"
                                stroke="currentColor"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                        ></path>
                        <path
                                d="M3 7L12 12L21 7"
                                stroke="currentColor"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                        ></path>
                        <path
                                d="M12 22V12"
                                stroke="currentColor"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                        ></path>
                    </svg>
                    <span
                            class="text-sm text-background-dark/70 dark:text-background-light/70"
                    >© 2024 Sahaayata. All rights reserved.</span
                    >
                </div>
                <div class="flex gap-4">
                    <a
                            class="text-background-dark/60 dark:text-background-light/60 hover:text-primary transition-colors"
                            href="#"
                    >
                        <svg
                                fill="currentColor"
                                height="20"
                                viewbox="0 0 256 256"
                                width="20"
                                xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                    d="M247.39,68.94A8,8,0,0,0,240,64H209.57A48.66,48.66,0,0,0,168.1,40a46.91,46.91,0,0,0-33.75,13.7A47.9,47.9,0,0,0,120,88v6.09C79.74,83.47,46.81,50.72,46.46,50.37a8,8,0,0,0-13.65,4.92c-4.31,47.79,9.57,79.77,22,98.18a110.93,110.93,0,0,0,21.88,24.2c-15.23,17.53-39.21,26.74-39.47,26.84a8,8,0,0,0-3.85,11.93c.75,1.12,3.75,5.05,11.08,8.72C53.51,229.7,65.48,232,80,232c70.67,0,129.72-54.42,135.75-124.44l29.91-29.9A8,8,0,0,0,247.39,68.94Zm-45,29.41a8,8,0,0,0-2.32,5.14C196,166.58,143.28,216,80,216c-10.56,0-18-1.4-23.22-3.08,11.51-6.25,27.56-17,37.88-32.48A8,8,0,0,0,92,169.08c-.47-.27-43.91-26.34-44-96,16,13,45.25,33.17,78.67,38.79A8,8,0,0,0,136,104V88a32,32,0,0,1,9.6-22.92A30.94,30.94,0,0,1,167.9,56c12.66.16,24.49,7.88,29.44,19.21A8,8,0,0,0,204.67,80h16Z"
                            ></path>
                        </svg>
                    </a>
                    <a
                            class="text-background-dark/60 dark:text-background-light/60 hover:text-primary transition-colors"
                            href="#"
                    >
                        <svg
                                fill="currentColor"
                                height="20"
                                viewbox="0 0 256 256"
                                width="20"
                                xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                    d="M128,80a48,48,0,1,0,48,48A48.05,48.05,0,0,0,128,80Zm0,80a32,32,0,1,1,32-32A32,32,0,0,1,128,160ZM176,24H80A56.06,56.06,0,0,0,24,80v96a56.06,56.06,0,0,0,56,56h96a56.06,56.06,0,0,0,56-56V80A56.06,56.06,0,0,0,176,24Zm40,152a40,40,0,0,1-40,40H80a40,40,0,0,1-40-40V80A40,40,0,0,1,80,40h96a40,40,0,0,1,40,40ZM192,76a12,12,0,1,1-12-12A12,12,0,0,1,192,76Z"
                            ></path>
                        </svg>
                    </a>
                    <a
                            class="text-background-dark/60 dark:text-background-light/60 hover:text-primary transition-colors"
                            href="#"
                    >
                        <svg
                                fill="currentColor"
                                height="20"
                                viewbox="0 0 256 256"
                                width="20"
                                xmlns="http://www.w3.org/2000/svg"
                        >
                            <path
                                    d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,191.63V152h24a8,8,0,0,0,0-16H136V112a16,16,0,0,1,16-16h16a8,8,0,0,0,0-16H152a32,32,0,0,0-32,32v24H96a8,8,0,0,0,0,16h24v63.63a88,88,0,1,1,16,0Z"
                            ></path>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </footer>
</div>
</body>
</html>