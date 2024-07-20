module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] shift_reg;

    localparam BYTE1 = 2'd0;
    localparam BYTE2 = 2'd1;
    localparam BYTE3 = 2'd2;
    localparam DONE  = 2'd3;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[2]) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Combinational logic for outputs and shifting register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2]) begin
                        shift_reg <= {shift_reg[15:0], in};
                    end
                    done <= 1'b0;
                end
                BYTE2: begin
                    shift_reg <= {shift_reg[15:0], in};
                    done <= 1'b0;
                end
                BYTE3: begin
                    shift_reg <= {shift_reg[15:0], in};
                    done <= 1'b0;
                end
                DONE: begin
                    out_bytes <= shift_reg;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
