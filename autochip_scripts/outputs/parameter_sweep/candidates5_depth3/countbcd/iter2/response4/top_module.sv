module top_module(
    input clk,
    input reset,
    output reg [2:0] ena,
    output reg [15:0] q
);

    reg [2:0] count;
    reg [3:0] q_temp; // temporary variable for q

    always @(posedge clk) begin
        if (reset) begin
            q_temp <= 0;
            ena <= 3'b000;
            count <= 3'b000;
        end else begin
            // Increment q_temp based on count value
            if (count == 3'b000) begin
                if (q_temp[3:0] < 9) begin
                    q_temp[3:0] <= q_temp[3:0] + 1;
                end else begin
                    q_temp[3:0] <= 0;
                    ena[2] <= 1;
                    count <= 3'b001;
                end
            end else if (count == 3'b001) begin
                if (q_temp[7:4] < 9) begin
                    q_temp[7:4] <= q_temp[7:4] + 1;
                end else begin
                    q_temp[7:4] <= 0;
                    ena[1] <= 1;
                    count <= 3'b010;
                end
            end else if (count == 3'b010) begin
                if (q_temp[11:8] < 9) begin
                    q_temp[11:8] <= q_temp[11:8] + 1;
                end else begin
                    q_temp[11:8] <= 0;
                    ena[0] <= 1;
                    count <= 3'b000;
                end
            end
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= q_temp;
        end
    end

endmodule
