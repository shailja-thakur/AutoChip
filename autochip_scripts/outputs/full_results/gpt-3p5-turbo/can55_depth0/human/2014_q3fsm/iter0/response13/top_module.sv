module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] w_count;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        state <= A;
        w_count <= 0;
    end else begin
        case (state)
            A: begin
                if (s == 1'b1) begin
                    state <= B;
                    w_count <= 0;
                end
            end
            B: begin
                w_count <= w_count + 1;
                if (w_count == 3) begin
                    if (w_count[2] == 1 && w_count[1] == 1 && w_count[0] == 0) begin
                        z <= 1'b0;
                    end else begin
                        z <= 1'b1;
                    end
                    w_count <= 0;
                end
            end
        endcase
    end
end

endmodule
