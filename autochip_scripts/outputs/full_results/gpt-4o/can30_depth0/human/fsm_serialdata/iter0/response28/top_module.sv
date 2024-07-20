module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state;
    reg [7:0] data;
    reg [2:0] bit_count;

    // State declaration
    localparam IDLE       = 4'b0000;
    localparam START_BIT  = 4'b0001;
    localparam DATA_BITS  = 4'b0010;
    localparam STOP_BIT   = 4'b0011;
    localparam ERROR      = 4'b0100;

    // FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            bit_count <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin  // Start bit detected
                        state <= START_BIT;
                    end
                end

                START_BIT: begin
                    if (in == 1'b0) begin  // Valid start bit
                        state <= DATA_BITS;
                        bit_count <= 3'b0;
                    end else begin
                        state <= IDLE;  // Not a valid start bit, go back to IDLE
                    end
                end

                DATA_BITS: begin
                    data[bit_count] <= in;
                    if (bit_count == 3'b111) begin
                        state <= STOP_BIT;
                    end else begin
                        bit_count <= bit_count + 1'b1;
                    end
                end

                STOP_BIT: begin
                    if (in == 1'b1) begin  // Valid stop bit
                        out_byte <= data;
                        done <= 1'b1;
                        state <= IDLE;
                    end else begin
                        state <= ERROR;  // Not a valid stop bit, transition to ERROR state
                    end
                end

                ERROR: begin
                    done <= 1'b0;
                    if (in == 1'b1) begin  // Wait for line to return to idle (logic 1)
                        state <= IDLE;
                    end
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
