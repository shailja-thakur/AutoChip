module top_module (
    input [2:0] sel,
    input [3:0] data0,
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    output reg [3:0] out
);
    
    // Wire to hold the selected data input
    wire [3:0] selected_data;
    
    // Assign the selected data input based on the value of `sel`
    assign selected_data = (sel == 3'b000) ? data0 :
                          (sel == 3'b001) ? data1 :
                          (sel == 3'b010) ? data2 :
                          (sel == 3'b011) ? data3 :
                          (sel == 3'b100) ? data4 :
                          (sel == 3'b101) ? data5 :
                                           4'b0000;
    
    // Register to hold the selected data input until `sel` is changed
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 4'b0000;
        end else begin
            out <= selected_data;
        end
    end
    
endmodule
