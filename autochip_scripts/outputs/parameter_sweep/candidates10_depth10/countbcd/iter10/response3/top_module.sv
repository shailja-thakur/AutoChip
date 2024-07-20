module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q
);

reg [3:0] q_next;
reg [2:0] ena_next;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        q <= 16'd0;
        ena <= 3'b0;
    end else begin
        ena <= ena_next;
        q <= q_next;
    end
end

always @* begin
    q_next = q;
    ena_next = ena;
    
    if (ena[1]) begin
        if (q[3:0] == 4'd9) begin
            q_next[3:0] = 4'd0;
            ena_next[1] = 0;
            if (ena[2]) begin
                if (q[7:4] == 4'd9) begin
                    q_next[7:4] = 4'd0;
                    ena_next[2] = 0;
                    if (ena[3]) begin
                        if (q[11:8] == 4'd9) begin
                            q_next[11:8] = 4'd0;
                        end else begin
                            q_next[11:8] = q[11:8] + 1;
                        end
                    end else begin
                        ena_next[3] = 1;
                    end
                end else begin
                    q_next[7:4] = q[7:4] + 1;
                end
            end else begin
                ena_next[2] = 1;
            end
        end else begin
            q_next[3:0] = q[3:0] + 1;
        end
    end else begin
        ena_next[1] = 1;
    end
end

endmodule
