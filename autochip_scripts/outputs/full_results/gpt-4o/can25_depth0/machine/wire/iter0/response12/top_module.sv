module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out);

    // FSM state declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;
    
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

    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                next_state = WAIT;
                data_out = 8'd0;
                valid_out = 1'b0;
            end
            WAIT: begin
                if (counter == 4'd10) begin
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end
            PROCESS: begin
                next_state = DONE;
                data_out = 8'hAA; // Example processed data
            end
            DONE: begin
                next_state = IDLE;
                valid_out = 1'b1;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
    // Counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'd0;
        end else if (state == WAIT) begin
            counter <= counter + 1;
        end else begin
            counter <= 4'd0;
        end
    end
endmodule
