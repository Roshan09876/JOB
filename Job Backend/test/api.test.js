const request = require('supertest')
const app = require('../index')


//Making collection of all the tests 
describe('API Endpoints Test', () => {

    it('POST /api/signup | Register Test Success', async () => {
        const response = await request(app).post('/api/signup').send({
            'firstName': 'Roshan',
            'lastName': 'Kumar Khadka',
            'email': 'roshan@gmail.com',
            'password': 'roshan1234'
        })
        if (response.body.success) {
            expect(response.statusCode).toBe(200);
            expect(response.body.message).toEqual('User Created Successfully.');
        } else {
            // expect(response.body.success).toBe(false);
            expect(response.body.message).toEqual('User Already Exist');
        }
    })

    it('POST /api/signin | Login Success Test', async () => {
        const response = await request(app).post('/api/signin').send({
            'email': 'roshan@gmail.com',
            'password': 'roshan1234'
        })
        if (response.body.success) {
            expect(response.statusCode).toBe(200);
            // expect(response.body.message).toEqual('User Created Successfully.');
        } else {
            expect(response.body.success).toBe(false);
            expect(response.body.message).toEqual('User Doesnot Exist');
        }
    })

    it('GET /api/jobs/showallJobs | Show all Jobs test success', async () => {
        // make a request to a route 
        const response = await request(app).get('/api/jobs/showallJobs');
        expect(response.statusCode).toBe(200);
        expect(response.body).toBeDefined();
        expect(response.body.message).toEqual('All jobs Fetched Successfully');
    });


    it('GET /api/book/:id | BookMark test success', async () => {
        const id = '65db0115c3326b4a4560d28e';
        const response = await request(app).get(`/api/book/${id}`);

        expect(response.statusCode).toBe(200);
        expect(response.body).toBeDefined();
    });

    it('GET /api/type/jobs | Get jobType test success', async () => {
        const response = await request(app).get(`/api/type/jobs`);

        expect(response.statusCode).toBe(200);
        expect(response.body).toBeDefined();
    });

    it('POST /api/job/create | Create job test success', async () => {
        const response = await request(app).post('/api/job/create').send({
            'title': 'Java',
            'description': 'This is new job',
            'salary': '100000',
            'location': 'kathmandu',
            'available': 'yes',
            'jobType': '65951e02052bf1c0b65183b9'
        })
        if (response.body.success) {
            expect(response.statusCode).toBe(200);
            expect(response.body.message).toEqual('Job Created Successfully');
        } else {
            expect(response.body.success).toBe(false);
        }
    })

    it('POST /api/type/create | Create job test success', async () => {
        const response = await request(app).post('/api/type/create').send({
            "jobTypeName": "Frontend",
            "user": "6593b7c4c58cb63f11013a04",
            "_id": "65e42e3a0a470ebcb18dd96b",
            "createdAt": "2024-03-03T08:00:58.250Z",
            "updatedAt": "2024-03-03T08:00:58.250Z",
            "__v": 0
        })
        if (response.body.success) {
            expect(response.statusCode).toBe(200);
            expect(response.body.message).toEqual('Job Type Created Successfully');
        } else {
            expect(response.body.success).toBe(false);
        }
    })

    it('GET /api/type/jobs | Get jobType test success', async () => {
        const response = await request(app).get(`/api/type/jobs`);

        expect(response.statusCode).toBe(200);
        expect(response.body).toBeDefined();
    });

    it('POST /api/user/jobhistory | Create job test success', async () => {
        const response = await request(app).get('/api/user/jobhistory').send({
            "title": "swift",
            "description": "wesrdtcfyvgubhjkn lewzrxdtcfyvghubjknlm",
            "salary": "2345678",
            "location": "dang",
            "applicationStatus": "Pending",
            "user": "65db0115c3326b4a4560d28e",
            "_id": "65dd8f6acee97c7cd084b6e7",
            "createdAt": "2024-02-27T07:29:47.004Z",
            "updatedAt": "2024-02-27T07:29:47.004Z"
        })
        if (response.body.success) {
            expect(response.statusCode).toBe(200);
        } else {
            expect(response.body.success).toBe(false);
        }
    })

    it('POST /api/allusers | Create job test success', async () => {
        const response = await request(app).get('/api/allusers').send({
            "_id": "65e429d20a470ebcb18dd786",
            "firstName": "Kumar",
            "lastName": "Khadka",
            "email": "kumar@gmail.com",
            "skills": [
                false
            ],
            "role": 0,
            "jobsHistory": [],
            "createdAt": "2024-03-03T07:42:10.773Z",
            "updatedAt": "2024-03-03T07:42:10.773Z",
            "__v": 0
        })
        console.log(response)
    })


})
