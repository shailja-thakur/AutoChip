module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] temp_bytes;
    reg [2:0] byte_count;

    // State encoding
    localparam WAIT_FOR_FIRST_BYTE = 2'b00,
               READ_BYTE1 = 2'b01,
               READ_BYTE2 = 2'b10,
               READ_BYTE3 = 2'b11;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_FIRST_BYTE;
            done <= 0;
            byte_count <= 0;
            out_bytes <= 24'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic & output logic
    always @(*) begin
        next_state = state; // Default to no change of state
        done = 0; // Default to not done

        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3]) begin
                    next_state = READ_BYTE1;
                end
            end

            READ_BYTE1: begin
                temp_bytes[23:16] = in;
                next_state = READ_BYTE2;
            end

            READ_BYTE2: begin
                temp_bytes[15:8] = in;
                next_state = READ_BYTE3;
            end

            READ_BYTE3: begin
                temp_bytes[7:0] = in;
                done = 1;
                next_state = WAIT_FOR_FIRST_BYTE;
            end
        endcase
    end

    // Store output bytes
    always @(posedge clk) begin
        if (state == READ_BYTE3) begin
            out_bytes <= temp_bytes;
        end
    end

    // Byte count for future use (optional)
    always @(posedge clk) begin
        if (reset) begin
            byte_count <= 0;
        end
        else if (state == READ_BYTE1 || state == READ_BYTE2 || state == READ_BYTE3) begin
            byte_count <= byte_count + 1;
        end
    end

endmodule
