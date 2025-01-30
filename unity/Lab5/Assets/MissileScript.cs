using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MissileScript : MonoBehaviour
{
    public GameObject expl;
    AudioSource audioSource;

    void Start()
    {
        GameObject audioSourceObject = GameObject.Find("Cube/AudioSource");
        if (audioSourceObject != null)
        {
            audioSource = audioSourceObject.GetComponentInParent<AudioSource>();
        }
        Destroy(gameObject, 5f);
    }

    void Update()
    {
        transform.position += transform.TransformDirection(Vector3.right * 0.8f);
    }
    private void OnCollisionEnter(Collision col)
    {
        if (col.gameObject.tag == "goal")
        {
            GetComponent<Renderer>().enabled = false;
            col.gameObject.GetComponent<Renderer>().material.color = new Color(1, 0, 0);
            Instantiate(expl, gameObject.transform);
            //audioSource.PlayOneShot(audioSource.clip);
        }
    }
}