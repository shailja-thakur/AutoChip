module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    // State encoding
    localparam IDLE = 2'b00,
               WAIT = 2'b01,
               PROCESS = 2'b10,
               DONE = 2'b11;

    reg [1:0] state, next_state;
    reg [7:0] counter;

    // FSM State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else if (state == IDLE)
                counter <= 8'b0;
        end
    end

    // FSM State Definition
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                data_out = 8'b0;
                valid_out = 1'b0;
                if (!reset)
                    next_state = WAIT;
            end

            WAIT: begin
                data_out = 8'b0;
                valid_out = 1'b0;
                if (counter >= 8'd255)  // Assume threshold is 255 for demo purposes
                    next_state = PROCESS;
            end

            PROCESS: begin
                data_out = 8'hFF;  // Replace with actual processing logic
                valid_out = 1'b0;
                next_state = DONE;
            end

            DONE: begin
                data_out = 8'hFF;  // Replace with actual processed data if needed
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
