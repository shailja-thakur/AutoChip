module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Declare state variables
    reg [1:0] current_state, next_state;

    // Define states
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE  = 2'b11;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE : next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Output and state register logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (current_state)
                BYTE1: begin
                    if (in[3]) begin
                        out_bytes <= {out_bytes[15:0], in};
                    end else begin
                        out_bytes <= {16'b0, in};
                    end
                    done <= 0;
                end
                BYTE2: begin
                    out_bytes <= {out_bytes[15:0], in};
                    done <= 0;
                end
                BYTE3: begin
                    out_bytes <= {out_bytes[15:0], in};
                    done <= 0;
                end
                DONE: begin
                    done <= 1;
                end
            endcase
        end
    end

endmodule
