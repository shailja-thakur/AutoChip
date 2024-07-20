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

// Internal signals
reg [1:0] state, next_state;
reg [7:0] counter;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 8'd0;
    end else begin
        state <= next_state;
        if (state == WAIT) begin
            counter <= counter + 8'd1;
        end else if (state == IDLE || state == DONE) begin
            counter <= 8'd0;
        end
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE:    next_state = WAIT;
        WAIT:    next_state = (counter == 8'd255) ? PROCESS : WAIT;
        PROCESS: next_state = DONE;
        DONE:    next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 8'd0;
        valid_out <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                data_out <= 8'd0;
                valid_out <= 1'b0;
            end
            WAIT: begin
                data_out <= 8'd0;
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
