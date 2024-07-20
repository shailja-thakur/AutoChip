module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

// FSM states
localparam IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;

// Internal signals
reg [1:0] state, next_state;
reg [3:0] counter;

// FSM state transition
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 4'b0; // Initialize counter in reset condition
    end else begin
        state <= next_state;
        if (state == WAIT)
            counter <= counter + 1;
        else
            counter <= 4'b0;
    end
end

// FSM next state logic and output logic
always @(*) begin
    next_state = state; // Default: hold the state
    data_out = 8'b0;
    valid_out = 1'b0;
    case(state)
        IDLE: begin
            counter = 4'b0;
            data_out = 8'b0;
            next_state = WAIT;
        end

        WAIT: begin
            if (counter < 4'b1111) begin
                data_out = 8'b0;
            end else begin
                next_state = PROCESS;
            end
        end

        PROCESS: begin
            data_out = 8'b10101010; // Example data
            next_state = DONE;
        end

        DONE: begin
            valid_out = 1'b1;
            next_state = IDLE;
        end
    endcase
end

endmodule
