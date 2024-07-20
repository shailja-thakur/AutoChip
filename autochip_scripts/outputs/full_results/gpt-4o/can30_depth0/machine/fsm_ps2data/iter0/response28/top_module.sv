module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State declarations
    typedef enum logic [1:0] {
        BYTE1 = 2'd0,
        BYTE2 = 2'd1,
        BYTE3 = 2'd2,
        DONE  = 2'd3
    } state_t;

    state_t state, next_state;
    reg [23:0] temp_bytes;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            BYTE1: if (in[2])
                       next_state = BYTE2;
                   else
                       next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (in[2])
                       next_state = DONE;
                   else
                       next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Output logic and register shift
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_bytes <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: if (in[2])
                           temp_bytes <= {temp_bytes[15:0], in};
                BYTE2: temp_bytes <= {temp_bytes[15:0], in};
                BYTE3: temp_bytes <= {temp_bytes[15:0], in};
                DONE:  begin
                           out_bytes <= temp_bytes;
                           done <= 1'b1;
                       end
            endcase
        end
    end

endmodule
