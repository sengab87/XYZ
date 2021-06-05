package com.example.abbassiasnotes.video

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.MediaController
import android.widget.VideoView
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.abbassiasnotes.FireBaseInstance
import com.example.abbassiasnotes.R
import com.example.abbassiasnotes.databinding.VideoFragmentBinding


class VideoFragment : Fragment() {

    private lateinit var binding: VideoFragmentBinding
    private lateinit var viewModelFactory: VideoViewModelFactory
    private lateinit var viewModel: VideoViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = DataBindingUtil.inflate(
            inflater,
            R.layout.video_fragment,
            container,
            false
        )

        viewModelFactory = VideoViewModelFactory(VideoFragmentArgs.fromBundle(arguments!!).url)
        viewModel = ViewModelProvider(this, viewModelFactory)
            .get(VideoViewModel::class.java)

        binding.videoViewModel = viewModel
        binding.lifecycleOwner = viewLifecycleOwner

        binding.videoViewModel
        viewModel.url.observe(viewLifecycleOwner, Observer<String> { status ->

            val videoView: VideoView = requireView().findViewById(R.id.videoView)
            FireBaseInstance.downloadUrl { url->
                videoView.setVideoPath(url)
                videoView.setMediaController(MediaController(requireContext()))
                videoView.requestFocus()
                videoView.setOnPreparedListener{
                    videoView.start()
                }
            }
//            videoView.setVideoPath("gs://abbassiasnotes-79f91.appspot.com/P1NOTES/RPReplay_Final1619124054.mp4")
//            videoView.start()

//            ffmpeg -i input.mp4 -c:v libx264 -preset fast -profile:v baseline out.mov


        })
        return binding.root
    }






}