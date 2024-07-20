module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State definitions
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    // State and next state variables
    state_t state, next_state;
    
    // Temporary register to hold the intermediate bytes
    reg [23:0] temp_bytes;
    
    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = BYTE1;
            default: next_state = BYTE1; // Default to BYTE1
        endcase
    end

    // State register update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_bytes <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                BYTE1: begin
                    done <= 1'b0;
                    temp_bytes <= {temp_bytes[15:0], in};
                end
                BYTE2: begin
                    temp_bytes <= {temp_bytes[15:0], in};
                end
                BYTE3: begin
                    temp_bytes <= {temp_bytes[15:0], in};
                end
                DONE: begin
                    out_bytes <= temp_bytes;
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
