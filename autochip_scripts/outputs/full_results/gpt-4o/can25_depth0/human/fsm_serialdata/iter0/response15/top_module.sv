module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE,        // Waiting for the start bit
        START,       // Detected the start bit, waiting for data bits
        DATA,        // Receiving the 8 data bits
        STOP,        // Waiting for the stop bit
        ERROR        // Error detected, wait for the next valid start bit
    } state_t;

    state_t state, next_state;
    reg [7:0] data;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
            out_byte <= 8'b0;
        end else begin
            state <= next_state;
            if (state == DATA) data <= {in, data[7:1]};
            if (state == DATA) bit_count <= bit_count + 1'b1;
            if (state == STOP) begin
                if (in == 1'b1) begin
                    out_byte <= data;
                    done <= 1'b1;
                end else begin
                    done <= 1'b0;
                end
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) next_state = START; // Detected start bit
            end
            START: begin
                next_state = DATA;
                bit_count = 3'b0;
            end
            DATA: begin
                if (bit_count == 3'b111) next_state = STOP; // All 8 data bits received
            end
            STOP: begin
                if (in == 1'b1) next_state = IDLE; // Stop bit detected correctly
                else next_state = ERROR; // Stop bit missing, go to ERROR state
            end
            ERROR: begin
                if (in == 1'b1) next_state = IDLE; // Wait for line to go idle (1) before checking for new start bit
            end
        endcase
    end

endmodule
