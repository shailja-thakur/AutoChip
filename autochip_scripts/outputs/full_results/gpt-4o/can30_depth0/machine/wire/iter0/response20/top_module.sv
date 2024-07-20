module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset state and signals
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'd0;
                end
                PROCESS: begin
                    data_out <= // logic to process data;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter == 8'd255) ? PROCESS : WAIT;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
