module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,         // Waiting for start bit
        START = 3'b001,        // Start bit detected
        DATA0 = 3'b010,        // Receiving bits 0 to 7
        DATA1 = 3'b011,
        DATA2 = 3'b100,
        DATA3 = 3'b101,
        DATA4 = 3'b110,
        DATA5 = 3'b111,
        DATA6 = 3'b000,
        DATA7 = 3'b001,
        STOP  = 3'b010         // Verifying stop bit
    } state_t;

    state_t current_state, next_state;
    reg [7:0] data_register;
    integer bit_counter;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            out_byte <= 8'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == DATA0 ||
            current_state == DATA1 ||
            current_state == DATA2 ||
            current_state == DATA3 ||
            current_state == DATA4 ||
            current_state == DATA5 ||
            current_state == DATA6 ||
            current_state == DATA7) begin
            data_register[bit_counter] <= in;
            bit_counter <= bit_counter + 1;
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                done = 0;
                if (~in) begin     // Detect start bit
                    next_state = START;
                    bit_counter = 0;
                end
            end
            START: begin
                if (in == 1'b0) begin // Remaining steady on start bit
                    next_state = DATA0;
                end
            end
            DATA0: begin
                if (bit_counter == 7) begin
                    next_state = DATA1;
                end
            end
            DATA1: next_state = DATA2;
            DATA2: next_state = DATA3;
            DATA3: next_state = DATA4;
            DATA4: next_state = DATA5;
            DATA5: next_state = DATA6;
            DATA6: next_state = DATA7;
            DATA7: next_state = STOP;

            STOP: begin
                if (in == 1'b1) begin // Verify stop bit
                    done = 1;
                    out_byte = data_register;
                    next_state = IDLE;
                end else begin // Wait for idle state to resume
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
