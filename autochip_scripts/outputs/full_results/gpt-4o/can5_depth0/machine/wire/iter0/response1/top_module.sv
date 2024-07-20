module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,  // Assuming 8-bit data output
    output reg valid_out
);

// State encoding
localparam IDLE = 2'd0;
localparam WAIT = 2'd1;
localparam PROCESS = 2'd2;
localparam DONE = 2'd3;

// Internal signals
reg [1:0] state;
reg [1:0] next_state;
reg [3:0] counter;  // Assuming 4-bit counter for demonstration

// State transition logic
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @ (*) begin
    case (state)
        IDLE: begin
            if (reset)
                next_state = IDLE;
            else
                next_state = WAIT;
        end
        WAIT: begin
            if (counter == 4'd10)  // Assuming threshold of 10
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
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output and counter logic
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 4'd0;
        data_out <= 8'd0;
        valid_out <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                counter <= 4'd0;
                data_out <= 8'd0;
                valid_out <= 1'b0;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 8'd0;
                valid_out <= 1'b0;
            end
            PROCESS: begin
                data_out <= 8'hA5;  // Example data for processing
                valid_out <= 1'b0;
            end
            DONE: begin
                valid_out <= 1'b1;
            end
        endcase
    end
end

endmodule
