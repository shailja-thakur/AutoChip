module top_module(
    input clk, 
    input reset, 
    output reg [7:0] data_out, 
    output reg valid_out
);

    // State Encoding
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic and Outputs
    always @(*) begin
        // Default assignments
        next_state = state;
        data_out = 8'd0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                counter = 4'd0;
                data_out = 8'd0;
                if (!reset) begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                counter = counter + 1;
                data_out = 8'd0;
                if (counter >= 4'd10) begin // Change threshold as needed
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                data_out = 8'hFF; // Example Data
                next_state = DONE;
            end

            DONE: begin
                data_out = 8'hFF;
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
