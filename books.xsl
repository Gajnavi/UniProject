<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- Main template -->
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>BookShop Catalogue</title>
        <link rel="stylesheet" href="style.css"/>
      </head>
      <body>

        <!-- Top hero strip reused from index but smaller -->
        <section class="hero-page hero-page-small">
          <nav>
            <div class="logo-holder">
              <img class="book-logo" src="components/—Pngtree—open book logo_15366757.png" alt="" />
              <p class="company-name">StarBooks</p>
            </div>

            <div class="nav-links">
              <ul class="nav-items">
                <li><a href="index.html">Home</a></li>
                <li><a href="books.xml">Books</a></li>
              </ul>
            </div>

            <div class="search-input-holder">
              <!-- same input, we will hook JS to this -->
              <input class="input-bar" type="text" placeholder="Search by title, author or genre..." />
            </div>
          </nav>

          <div class="hero-details hero-details-small">
            <div class="book-details">
              <h1 class="book-title">
                Browse our <span class="text-enhanced">Catalogue</span>
              </h1>
              <p class="author-name">
                Find your next favourite book by genre.
              </p>
            </div>
          </div>
        </section>

        <!-- Same category bar as home, but local anchors -->
        <section>
          <div class="category-list">
            <ul class="lists">
              <li><a href="#top-trending">Top Trending</a></li>
              <li><a href="#fiction">Fiction</a></li>
              <li><a href="#children">Children</a></li>
              <li><a href="#self-help">Self-help</a></li>
              <li><a href="#education">Education</a></li>
              <li><a href="#mystery">Mystery</a></li>
            </ul>
          </div>
        </section>

        <main class="books-page">

          <!-- Top Trending: first 8 books -->
          <section id="top-trending" class="genre-section">
            <div class="genre-header">
              <h2>Top Trending</h2>
            </div>
            <div class="book-grid">
              <xsl:for-each select="books/book[position() &lt;= 8]">
                <xsl:call-template name="book-card"/>
              </xsl:for-each>
            </div>
          </section>

          <!-- Fiction: modern / historical / romance / thriller etc. -->
          <section id="fiction" class="genre-section">
            <div class="genre-header">
              <h2>Fiction</h2>
            </div>
            <div class="book-grid">
              <xsl:for-each
                select="books/book[
                  genre='Fiction' or
                  genre='Modern Fiction' or
                  genre='Historical Fiction' or
                  genre='Romance' or
                  genre='Psychological' or
                  genre='Thriller'
                ]">
                <xsl:call-template name="book-card"/>
              </xsl:for-each>
            </div>
          </section>

          <!-- Children: children + fantasy (Harry Potter, Percy Jackson, etc.) -->
          <section id="children" class="genre-section">
            <div class="genre-header">
              <h2>Children</h2>
            </div>
            <div class="book-grid">
              <xsl:for-each
                select="books/book[
                  genre='Children' or
                  genre='Fantasy'
                ]">
                <xsl:call-template name="book-card"/>
              </xsl:for-each>
            </div>
          </section>

          <!-- Self help -->
          <section id="self-help" class="genre-section">
            <div class="genre-header">
              <h2>Self-help</h2>
            </div>
            <div class="book-grid">
              <xsl:for-each select="books/book[genre='Self-help']">
                <xsl:call-template name="book-card"/>
              </xsl:for-each>
            </div>
          </section>

          <!-- Education: non-fiction and classics -->
          <section id="education" class="genre-section">
            <div class="genre-header">
              <h2>Education</h2>
            </div>
            <div class="book-grid">
              <xsl:for-each
                select="books/book[
                  genre='Non-fiction' or
                  genre='Classic'
                ]">
                <xsl:call-template name="book-card"/>
              </xsl:for-each>
            </div>
          </section>

          <!-- Mystery / horror -->
          <section id="mystery" class="genre-section">
            <div class="genre-header">
              <h2>Mystery</h2>
            </div>
            <div class="book-grid">
              <xsl:for-each
                select="books/book[
                  genre='Mystery' or
                  genre='Horror'
                ]">
                <xsl:call-template name="book-card"/>
              </xsl:for-each>
            </div>
          </section>

        </main>

        <!-- Simple footer to match home -->
        <footer>
          <div class="footer-logo">
            <div class="logo-holder">
              <img class="book-logo" src="components/—Pngtree—open book logo_15366757.png" alt="" />
              <p class="company-name">BookShop</p>
            </div>
          </div>

          <div class="footer-nav">
            <ul>
              <li><a href="index.html">Home</a></li>
              <li>About</li>
              <li>Contact</li>
              <li>Terms Of Service</li>
            </ul>
          </div>

          <p class="rights">© 2023. Bookshop All rights reserved.</p>
        </footer>

        <!-- Modal + search script -->
        <script><![CDATA[
          document.addEventListener('DOMContentLoaded', function () {
            const buttons = document.querySelectorAll('.book-card-button');
            const closeButtons = document.querySelectorAll('.modal-close');
            const searchInput = document.querySelector('.input-bar');

            // Modal open
            buttons.forEach(function (btn) {
              btn.addEventListener('click', function () {
                const id = this.getAttribute('data-modal');
                const modal = document.getElementById(id);
                if (modal) {
                  modal.classList.add('show');
                }
              });
            });

            // Modal close
            closeButtons.forEach(function (btn) {
              btn.addEventListener('click', function () {
                const modal = this.closest('.modal');
                if (modal) {
                  modal.classList.remove('show');
                }
              });
            });

            // Close when clicking overlay
            window.addEventListener('click', function (e) {
              if (e.target.classList.contains('modal')) {
                e.target.classList.remove('show');
              }
            });

            // SEARCH: filter book cards by title, author, or genre
            if (searchInput) {
              searchInput.addEventListener('input', function () {
                const query = this.value.toLowerCase();
                const cards = document.querySelectorAll('.book-card');

                cards.forEach(function (card) {
                  const titleEl = card.querySelector('.book-card-title');
                  const authorEl = card.querySelector('.book-card-author');
                  const genreEl = card.querySelector('.book-genre');

                  const title = titleEl ? titleEl.textContent.toLowerCase() : '';
                  const author = authorEl ? authorEl.textContent.toLowerCase() : '';
                  const genre = genreEl ? genreEl.textContent.toLowerCase() : '';

                  if (
                    query === '' ||
                    title.indexOf(query) !== -1 ||
                    author.indexOf(query) !== -1 ||
                    genre.indexOf(query) !== -1
                  ) {
                    card.style.display = '';
                  } else {
                    card.style.display = 'none';
                  }
                });
              });
            }
          });
        ]]></script>

      </body>
    </html>
  </xsl:template>

  <!-- Template for a single book card -->
  <xsl:template name="book-card">
    <div class="book-card">
      <div class="book-cover">
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="thumbnail"/>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:value-of select="title"/>
          </xsl:attribute>
        </img>
      </div>

      <p class="book-card-title">
        <xsl:value-of select="title"/>
      </p>

      <p class="book-card-author">
        <xsl:value-of select="authors"/>
      </p>

      <!-- Hidden genre text to help search -->
      <p class="book-genre" style="display:none;">
        <xsl:value-of select="genre"/>
      </p>

      <p class="book-card-price">
        <xsl:text>MUR </xsl:text>
        <xsl:value-of select="price"/>
      </p>

      <!-- Button opens modal -->
      <button class="book-card-button" data-modal="modal-{@id}">
        VIEW DESCRIPTION
      </button>

      <!-- Modal for this book -->
      <div class="modal" id="modal-{@id}">
        <div class="modal-content">
          <span class="modal-close">×</span>
          <h2><xsl:value-of select="title"/></h2>
          <p class="modal-author"><xsl:value-of select="authors"/></p>
          <p class="modal-description">
            <xsl:value-of select="description"/>
          </p>
        </div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
