module top_module(
    output reg zero); // Added "reg" to declare zero as a reg type

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin // Changed "rst" to "rst_n"
            zero <= 1'b0; // Initialized zero to 0
        end else begin
            zero <= 1'b0; // Assigned zero to 0
        end
    end

endmodule
