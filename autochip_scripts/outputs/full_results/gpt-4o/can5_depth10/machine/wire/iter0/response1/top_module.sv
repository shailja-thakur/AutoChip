module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] counter;

    // State transition logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) 
                    next_state = IDLE;
                else 
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter >= 8'hFF) // Example threshold
                    next_state = PROCESS;
                else 
                    next_state = WAIT;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic and counter update
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 8'h00;
            data_out <= 8'h00;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'h00;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'hAA; // Example processed data
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end
endmodule
