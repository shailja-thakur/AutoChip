module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10;

reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        counter <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
                else state <= A;
                counter <= 0;
            end
            B: begin
                counter <= counter + 1;
                if (counter == 2'd2) begin
                    if (w) z <= 1;
                    else z <= 0;
                    state <= C;
                end
                else state <= B;
            end
            C: begin
                counter <= counter + 1;
                if (counter == 2'd3) begin
                    state <= B;
                    counter <= 0;
                end
                else state <= C;
            end
            default: state <= A;
        endcase
    end
end

endmodule
