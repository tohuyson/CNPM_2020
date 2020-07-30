<?php


namespace App;



class Movie
{
    private $id;
    private $name;
    private $duration;// thời gian chiếu
    private $link_trailer;
    private $director;// đạo diễn
    private $cast;// diên viên
    private $genre;//thẻ loại
    private $language;
    private $release_date;// ngày phát hành
    private $rated;// đánh giá
    private $content;// nội dung phim

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @return mixed
     */
    public function getDuration()
    {
        return $this->duration;
    }

    /**
     * @return mixed
     */
    public function getLinkTrailer()
    {
        return $this->link_trailer;
    }

    /**
     * @return mixed
     */
    public function getDirector()
    {
        return $this->director;
    }

    /**
     * @return mixed
     */
    public function getCast()
    {
        return $this->cast;
    }

    /**
     * @return mixed
     */
    public function getGenre()
    {
        return $this->genre;
    }

    /**
     * @return mixed
     */
    public function getLanguage()
    {
        return $this->language;
    }

    /**
     * @return mixed
     */
    public function getReleaseDate()
    {
        return $this->release_date;
    }

    /**
     * @return mixed
     */
    public function getRated()
    {
        return $this->rated;
    }

    /**
     * @return mixed
     */
    public function getContent()
    {
        return $this->content;
    }
}
