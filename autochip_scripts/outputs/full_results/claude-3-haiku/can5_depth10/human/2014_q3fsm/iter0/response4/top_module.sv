module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

localparam [1:0] A = 2'b00, B = 2'b01, C = 2'b10;
reg [1:0] state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
                else state <= A;
            end
            B: begin
                if (w) count <= count + 1;
                else count <= count;
                if (count == 2) begin
                    z <= 1;
                    state <= C;
                end
                else state <= B;
            end
            C: begin
                z <= 0;
                state <= B;
                count <= 0;
            end
            default: state <= A;
        endcase
    end
end

endmodule
