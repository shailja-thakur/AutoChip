module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    // State Declarations
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Internal signals
    state_t state, next_state;
    reg [3:0] counter; // Adjust size as necessary

    // FSM State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM Next State Logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (!reset)
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter == 4'b1111) // Adjust threshold as necessary
                    next_state = PROCESS;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

    // FSM Output Logic and Counter Management
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'd0;
            data_out <= 8'd0;
            valid <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'd0;
                    data_out <= 8'd0;
                    valid <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                    valid <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'd255; // Placeholder for actual data processing logic
                    valid <= 1'b0;
                end
                DONE: begin
                    valid <= 1'b1;
                end
            endcase
        end
    end

endmodule
