//
//  DetailVC.swift
//  Template
//
//  Created by Apple on 03/03/22.
//

import UIKit
import AVKit

class DetailVC: UIViewController {

    let song: SongModel
    var playerVC = AVPlayerViewController()
    
    var playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    var lblSongName: UILabel = {
        let songName = UILabel()
        songName.numberOfLines = 0
        songName.textColor = .black
        songName.font = UIFont.systemFont(ofSize: 18)
        songName.translatesAutoresizingMaskIntoConstraints = false
        
        return songName
    }()
    
    var lblArtistName: UILabel = {
        let artistName = UILabel()
        songName.numberOfLines = 0
        artistName.textColor = .black
        artistName.font = UIFont.systemFont(ofSize: 18)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        
        return artistName
    }()
    
    var lblAlbumName: UILabel = {
        let albumName = UILabel()
        songName.numberOfLines = 0
        albumName.textColor = .black
        albumName.font = UIFont.systemFont(ofSize: 18)
        albumName.translatesAutoresizingMaskIntoConstraints = false
        
        return albumName
    }()
    
    init(with result: SongModel) {
        song = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white

        view.addSubview(playerView)
        view.addSubview(lblSongName)
        view.addSubview(lblArtistName)
        view.addSubview(lblAlbumName)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: margins.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),
            
            lblSongName.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            lblSongName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblSongName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lblArtistName.topAnchor.constraint(equalTo: lblSongName.bottomAnchor, constant: 20),
            lblArtistName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblArtistName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lblAlbumName.topAnchor.constraint(equalTo: lblArtistName.bottomAnchor, constant: 20),
            lblAlbumName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblAlbumName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        lblSongName.text = "Song: \(song.trackName ?? "-")"
        lblArtistName.text = "Artist: \(song.artistName ?? "-")"
        lblAlbumName.text = "Album: \(song.collectionName ?? "-")"
        
        guard let url = song.previewURL else {return}
        
        guard let videoURL = URL(string: url) else {return}
        playerVC.player = AVPlayer(url: videoURL)
        playerVC.view.frame = playerView.frame
        playerView.addSubview(playerVC.view)
        
    }
    
}
