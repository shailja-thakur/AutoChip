module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [7:0] buffer [2:0];
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_bytes <= 0;
        done <= 0;
        state <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3]) begin
                    buffer[0] <= in;
                    state <= 1;
                end
            end
            1: begin
                buffer[1] <= in;
                state <= 2;
            end
            2: begin
                buffer[2] <= in;
                out_bytes <= {buffer[0], buffer[1], buffer[2]};
                done <= 1;
                state <= 0;
            end
        endcase
    end
end

endmodule
