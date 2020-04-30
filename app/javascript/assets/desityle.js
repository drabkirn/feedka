// Drabkirn Desityle - See License at: https://go.cdadityang.xyz/DcenS

// Navbar configuration START
document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('turbolinks:load', function () {
    const htmlTag = document.querySelector('html');

    const fixedNavbar = document.querySelector('.fixed-navbar');

    if(fixedNavbar) {
      const fixedNavbarHamburgerMenuButton = document.querySelector('.fixed-navbar-hamburger a');
      const fixedNavbarHamburgerMenuAllLinks = document.querySelector('.fixed-navbar-hamburger .fixed-navbar-hamburger-links');
      const defaultNavbarHamburgerMenuButton = document.querySelector('.default-navbar-hamburger a');
      const defaultNavbarHamburgerMenuAllLinks = document.querySelector('.default-navbar-hamburger .default-navbar-hamburger-links');

      const fixedNavbarHamburgerMenuEachLinks = document.querySelectorAll('.fixed-navbar-hamburger .fixed-navbar-hamburger-links li a');
      const defaultNavbarHamburgerMenuEachLinks = document.querySelectorAll('.default-navbar-hamburger .default-navbar-hamburger-links li a');


      // Navbar Scroll
      document.addEventListener('scroll', function() {
        if(htmlTag.scrollTop > 70) {
          fixedNavbar.style.display = "block";
        }
        else {
          fixedNavbar.style.display = "none";
        }
      });

      // Navbar Hamburgers
      fixedNavbarHamburgerMenuButton.addEventListener('click', function() {
        if (fixedNavbarHamburgerMenuAllLinks.style.display === "block") {
          fixedNavbarHamburgerMenuAllLinks.style.display = "none";
        } else {
          fixedNavbarHamburgerMenuAllLinks.style.display = "block";
        }
      });

      for(let i = 0; i < fixedNavbarHamburgerMenuEachLinks.length; i++) {
        (function() {
          let temp = i;

          fixedNavbarHamburgerMenuEachLinks[temp].addEventListener('click', function() {
            fixedNavbarHamburgerMenuAllLinks.style.display = "none";
          });
        }());
      }

      defaultNavbarHamburgerMenuButton.addEventListener('click', function() {
        if (defaultNavbarHamburgerMenuAllLinks.style.display === "block") {
          defaultNavbarHamburgerMenuAllLinks.style.display = "none";
        } else {
          defaultNavbarHamburgerMenuAllLinks.style.display = "block";
        }
      });

      for(let i = 0; i < defaultNavbarHamburgerMenuEachLinks.length; i++) {
        (function() {
          let temp = i;

          defaultNavbarHamburgerMenuEachLinks[temp].addEventListener('click', function() {
            defaultNavbarHamburgerMenuAllLinks.style.display = "none";
          });
        }());
      }
    }
  })
});
// Navbar configuration END



// Content click modal START
document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('turbolinks:load', function () {
    const allContentClickModals = document.querySelectorAll('.content-click-modal');
    const allModals = document.querySelectorAll('.modal');

    const body = document.querySelector('body');

    let isModalOpened = false;
    let modalNumber;

    for (let i = 0; i < allModals.length; i++) {
      (function(){
        let temp = i;

        allContentClickModals[temp].addEventListener('click', function() {
          body.style.overflow = "hidden";
          allModals[temp].style.display = "block";
          modalNumber = temp;
          isModalOpened = true;
          window.location.href = "#modal-dialog";
        });
    
        allModals[temp].addEventListener('click', function(e) {
          if(isModalOpened) {
            if(e.target.id === "modal" || e.target.id === "modal-close") {
              body.style.overflow = "auto";
              allModals[modalNumber].style.display = "none";
              isModalOpened = false;
              window.location.href = "#";
            }
          }
        });
      }());
    }
  });
});
// Content click modal END