using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TubeScript : MonoBehaviour
{

    public GameObject missile;
    Vector3 tubePosition;

    AudioSource audioSource;

    void Start()
    {
        GameObject audioSourceObject = GameObject.Find("tube/AudioSource");
        if (audioSourceObject != null)
        {
            audioSource = audioSourceObject.GetComponentInParent<AudioSource>();
        }
    }

    void Update()
    {
        tubePosition = transform.position;

        if (Input.GetKeyDown(KeyCode.Space))
        {
            Vector3 spawnPosition = transform.position + transform.right * 6f;

            Instantiate(missile, spawnPosition, transform.rotation);

            audioSource.PlayOneShot(audioSource.clip);

        }
    }
}
