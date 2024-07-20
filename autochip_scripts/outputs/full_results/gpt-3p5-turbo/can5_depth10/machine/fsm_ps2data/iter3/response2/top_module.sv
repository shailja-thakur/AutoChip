module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @(state, in) begin
        case (state)
            3'b000: begin
                if (in[2] == 1)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
            end
            3'b001: begin
                if (in[2] == 1)
                    next_state = 3'b010;
                else
                    next_state = 3'b000;
            end
            3'b010: begin
                if (in[2] == 1)
                    next_state = 3'b011;
                else
                    next_state = 3'b000;
            end
            3'b011: begin
                if (in[2] == 1)
                    next_state = 3'b011;
                else
                    next_state = 3'b000;
            end
            default: next_state = 3'b000;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 0;
            done <= 0;
        end else if (state == 3'b011) begin
            out_bytes <= {8'b0, in};
            done <= 1;
        end else begin
            out_bytes <= {out_bytes[15:0], in};
            done <= 0;
        end
    end

endmodule
