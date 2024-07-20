module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] byte_buffer;

    // State encoding
    localparam IDLE  = 2'b00,
               BYTE1 = 2'b01,
               BYTE2 = 2'b10,
               BYTE3 = 2'b11;

    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output and Buffer Logic
    always @(posedge clk) begin
        if (reset) begin
            byte_buffer <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            done <= 1'b0; // Default
            case(state)
                IDLE: begin
                    byte_buffer <= byte_buffer; // Do nothing, keep buffer as is.
                end
                BYTE1: begin
                    byte_buffer[23:16] <= in;
                end
                BYTE2: begin
                    byte_buffer[15:8] <= in;
                end
                BYTE3: begin
                    byte_buffer[7:0] <= in;
                    out_bytes <= {byte_buffer[23:8], in};
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
