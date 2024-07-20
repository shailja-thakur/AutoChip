module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// State Definitions
localparam S_IDLE = 2'b00;  // Idle state
localparam S_START = 2'b01; // Start bit state
localparam S_DATA = 2'b10;  // Data bit states
localparam S_STOP = 2'b11;  // Stop bit state

// State Register
reg [1:0] state;

// Counter to keep track of the number of data bits received
reg [2:0] bit_counter;

// Register to store the received byte
reg [7:0] received_byte;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset FSM to idle state
        state <= S_IDLE;
        bit_counter <= 3'b0;
        done <= 1'b0;
        out_byte <= 8'b0;
        received_byte <= 8'b0;
    end
    else begin
        case (state)
            S_IDLE:
                if (in) begin
                    state <= S_START;
                    bit_counter <= 3'b0;
                    received_byte <= 8'b0;
                end
            S_START:
                if (!in)
                    state <= S_DATA;
            S_DATA:
                begin
                    if (bit_counter == 3'b111) begin
                        state <= S_STOP;
                        received_byte <= received_byte << 1;
                        received_byte[0] <= in;
                    end
                    else begin
                        bit_counter <= bit_counter + 1;
                        received_byte <= received_byte << 1;
                        received_byte[0] <= in;
                    end
                end
            S_STOP:
                if (in) begin
                    out_byte <= received_byte;
                    done <= 1'b1;
                    state <= S_IDLE;
                end
        endcase
    end
end

endmodule
