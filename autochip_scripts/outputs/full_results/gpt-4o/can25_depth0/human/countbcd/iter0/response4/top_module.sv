module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire incr_1, incr_2, incr_3; // Internal enable signals for digits
    
    assign ena[1] = (q[3:0] == 4'd9); // Enable for tens place
    assign ena[2] = (q[7:4] == 4'd9) && ena[1]; // Enable for hundreds place
    assign ena[3] = (q[11:8] == 4'd9) && ena[2]; // Enable for thousands place
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0;
        end else begin
            // Ones digit
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                incr_1 = 1'b1;
            end else begin
                q[3:0] <= q[3:0] + 4'd1;
                incr_1 = 1'b0;
            end
            
            // Tens digit
            if (incr_1) begin
                if (q[7:4] == 4'd9) begin
                    q[7:4] <= 4'd0;
                    incr_2 = 1'b1;
                end else begin
                    q[7:4] <= q[7:4] + 4'd1;
                    incr_2 = 1'b0;
                end
            end
            
            // Hundreds digit
            if (incr_2) begin
                if (q[11:8] == 4'd9) begin
                    q[11:8] <= 4'd0;
                    incr_3 = 1'b1;
                end else begin
                    q[11:8] <= q[11:8] + 4'd1;
                    incr_3 = 1'b0;
                end
            end
            
            // Thousands digit
            if (incr_3) begin
                if (q[15:12] == 4'd9) begin
                    q[15:12] <= 4'd0;
                end else begin
                    q[15:12] <= q[15:12] + 4'd1;
                end
            end
        end
    end

endmodule
