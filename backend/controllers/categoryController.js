const Category = require('../models/Category');


module.exports = {
    createCategory: async (req, res) => {
        const newCategory = new Category(req.body)

        try {
            await newCategory.save();
            res.status(201).json({
                status: true,
                message: 'Category created successfully'
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error
            })
        }
    },

    getAllCategories: async (req, res) => {
        try {
            // ne => not equal (lấy ra danh sách categories ngoại trừ dữ liệu có thuộc tính title là More)
            const categories = await Category.find({ title: { $ne: "More" } }, { __v: 0 });
            res.status(200).json({
                status: true,
                data: categories
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error
            })
        }
    },

    getRandomCategories: async (req, res) => {
        try {
            // `aggregate` sử dụng để thực hiện phép toán phức tạp, nhận vào một mảng các giai đoạn (`stages`)
            let categories = await Category.aggregate([
                // thực hiện giai đoạn 1, lọc ra các categories có giá trị `value` có giá trị khác `more`
                { $match: { value: { $ne: "more" } } },
                // giai đoạn 2: lấy ngẫu nhiên 4 docs từ kết quả của giai đoạn 1
                { $sample: { size: 4 } }
            ])


            // tìm tài liệu có danh mục value là `more` 
            const moreCategory = await Category.findOne({ value: "more" }, { __v: 0 });


            // nếu tìm thấy tài liệu `more`, thêm vào mảng categories
            if (moreCategory) {
                categories.push(moreCategory);
            }

            res.status(200).json({
                status: true, data: categories
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error
            })
        }
    }
}