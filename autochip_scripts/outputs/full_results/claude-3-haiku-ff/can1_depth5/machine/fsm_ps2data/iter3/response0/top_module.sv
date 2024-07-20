module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            BYTE1: begin
                out_bytes <= {out_bytes[15:0], in};
            end
            BYTE2: begin
                out_bytes <= {out_bytes[15:0], in};
            end
            BYTE3: begin
                out_bytes <= {out_bytes[23:8], in};
                done <= 1;
            end
            DONE: begin
                done <= 0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = DONE;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE1;
            end
            else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = BYTE1;
        end
    endcase
end

endmodule
