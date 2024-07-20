module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out);

// State Declaration
typedef enum reg [1:0] {
    STATE_IDLE = 2'b00,
    STATE_WAIT = 2'b01,
    STATE_PROCESS = 2'b10,
    STATE_DONE = 2'b11
} state_t;

// Internal signals
reg [7:0] counter;
reg state_t state;

// Initialize FSM
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        counter <= 8'd0;
        data_out <= 8'd0;
        valid_out <= 1'b0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                counter <= 8'd0;
                data_out <= 8'd0;
                valid_out <= 1'b0;
                state <= STATE_WAIT;
            end
            
            STATE_WAIT: begin
                counter <= counter + 1;
                data_out <= 8'd0;
                if (counter == 8'd255)   // Adjust the threshold as required
                    state <= STATE_PROCESS;
            end
            
            STATE_PROCESS: begin
                data_out <= 8'hA5;  // Example data processing; replace with actual logic
                state <= STATE_DONE;
            end
            
            STATE_DONE: begin
                valid_out <= 1'b1;
                state <= STATE_IDLE;
            end
            
            default: state <= STATE_IDLE;
        endcase
    end
end

endmodule
