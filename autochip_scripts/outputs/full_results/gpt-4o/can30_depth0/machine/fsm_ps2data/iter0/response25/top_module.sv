module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [23:0] out_bytes_reg;

    localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Determine next state
    always @(*) begin
        case (state)
            BYTE1: if (in[2] == 1'b1)
                       next_state = BYTE2;
                   else
                       next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (in[2] == 1'b0)
                       next_state = BYTE1;
                   else
                       next_state = DONE;
            default: next_state = BYTE1;
        endcase
    end

    // Output logic and register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: begin
                    out_bytes_reg <= {out_bytes_reg[15:0], in};
                    done <= 1'b0;
                end
                BYTE2: out_bytes_reg <= {out_bytes_reg[15:0], in};
                BYTE3: out_bytes_reg <= {out_bytes_reg[15:0], in};
                DONE: begin
                    out_bytes <= out_bytes_reg;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
