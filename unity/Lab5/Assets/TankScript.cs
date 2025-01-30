using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TankScript : MonoBehaviour
{
    Transform twr;
    Transform tb;
    float TankMoveSpeed = 0.3f;
    float RotateSpeed = 1f;

    public GameObject bomb;
    public float multipliier = 2f;
    public float dropHeight = 30f;
    Vector3 tankPosition;

    private float currentRotationZ = 0f;

    //
    AudioSource zvtank;
    bool isPlaying = false;
    //

    void Start()
    {
        twr = gameObject.transform.Find("tower");
        tb = gameObject.transform.Find("tower/tube");
        tankPosition = transform.position;

        //
        GameObject audioSourceObject = GameObject.Find("corpus/AudioSource");
        if (audioSourceObject != null)
        {
            zvtank = audioSourceObject.GetComponentInParent<AudioSource>();
        }
        //
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Q))
        {
            float areaSizeX = 8 * multipliier; 
            float areaSizeZ = 16 * multipliier; 

            float randomX = Random.Range(-areaSizeX / 2, areaSizeX / 2);
            float randomZ = Random.Range(-areaSizeZ / 2, areaSizeZ / 2);

            Vector3 dropPosition = new Vector3(tankPosition.x + randomX, tankPosition.y + dropHeight, tankPosition.z + randomZ);

            Instantiate(bomb, dropPosition, Quaternion.identity);
        }

        float z = Input.GetAxis("Vertical");
        transform.Translate(z * TankMoveSpeed, 0, 0);

        float x = Input.GetAxis("Horizontal");
        transform.Rotate(0f, x, 0f);

        float h = Input.GetAxis("Mouse X");
        twr.Rotate(0f, h * RotateSpeed, 0f);

        float v = Input.GetAxis("Mouse Y");
        currentRotationZ += v * RotateSpeed;
        currentRotationZ = Mathf.Clamp(currentRotationZ, -10f, 30f);
        tb.localRotation = Quaternion.Euler(0, 0, currentRotationZ);

        //
        if ((Input.GetAxis("Horizontal") != 0 || Input.GetAxis("Vertical") != 0) && !isPlaying){
            zvtank.Play(); 
            isPlaying = true; 
        }

        if (Input.GetAxis("Horizontal") == 0 && Input.GetAxis("Vertical") == 0 && isPlaying){
            zvtank.Stop(); 
            isPlaying = false; 
        }

        //

    }

}
