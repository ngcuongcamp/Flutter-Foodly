const nodemailer = require('nodemailer');

const sendEmail = async (userEmail, message) => {
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.EMAIL,
            pass: process.env.PASSWORD
        }
    })

    const mailOptions = {
        from: process.env.AUTH_EMAIL,
        to: userEmail,
        subject: 'Foodly Verification Code',
        html: `<h1>Foodly Email Verification</h1>
                <p>Your veritification code is: </p> 
                <h2 style="color: blue;">${message} </h2>
                <p>Please enter this code on the verification page to complete your registration process.</p>
                <p>If you did not request this, please ignore the email!</p>
        `
    }

    try {
        await transporter.sendMail(mailOptions);
        console.log('Verification email sent');
    }
    catch (error) {
        console.log('Email sending failed with an error:', error);
    }
}

module.exports = sendEmail;