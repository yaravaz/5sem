using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.EventSystems;

public class New_script : MonoBehaviour, IPointerClickHandler
{

    public void OnPointerClick(PointerEventData eventData)
    {
        float red = Random.Range(0.0f, 1.0f);
        float green = Random.Range(0.0f, 1.0f);
        float blue = Random.Range(0.0f, 1.0f);
        Color col1 = new Color(red, green, blue);

        gameObject.GetComponent<Renderer>().material.color = col1;

        Vector3 target = eventData.pointerPressRaycast.worldPosition;
        Vector3 collid = Camera.main.transform.position;

        int force = 1000;
        Vector3 distance = (target - collid).normalized;

        Vector3 collid2 = distance * force;
        gameObject.GetComponent<Rigidbody>().AddForceAtPosition(collid2, target);
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
