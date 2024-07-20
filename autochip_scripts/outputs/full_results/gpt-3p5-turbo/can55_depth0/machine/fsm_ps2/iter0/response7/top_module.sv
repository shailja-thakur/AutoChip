module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Define states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define internal state variable
reg [1:0] state;

// Define done signal
assign done = (state == DONE);

// Declare next state variable
reg [1:0] next_state;

// State machine logic
always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        state <= next_state;
    end
end

// Combinational logic to determine next_state and transitions based on current state
always @(in) begin
    case (state)
        BYTE1: begin
            if (in[2] == 1'b1) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = DONE;
        end
        DONE: begin
            if (in[2] == 1'b1) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
    endcase
end

endmodule
