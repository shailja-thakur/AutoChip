module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
    );

    // State encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter; // 4-bit counter for demonstration

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'd0; 
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = state;
        valid_out = 1'b0;
        case (state)
            IDLE: begin
                data_out = 8'd0;
                counter = 4'd0;
                if (!reset) begin
                    next_state = WAIT;
                end
            end
            
            WAIT: begin
                data_out = 8'd0;
                counter = counter + 4'd1;
                if (counter == 4'd15) begin // Assuming threshold is 15 for demonstration
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                data_out = 8'hAA; // Example data being processed
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
