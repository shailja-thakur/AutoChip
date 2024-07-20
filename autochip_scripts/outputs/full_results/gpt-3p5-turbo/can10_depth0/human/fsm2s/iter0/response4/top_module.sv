module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// Define the two states
parameter OFF = 1'b0;
parameter ON = 1'b1;

// Define the state register
reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= OFF;
    end else begin
        current_state <= next_state;
    end
end

always @* begin
    case (current_state)
        OFF: begin
            if (j) begin
                next_state = ON;
            end else begin
                next_state = OFF;
            end
        end
        
        ON: begin
            if (k) begin
                next_state = OFF;
            end else begin
                next_state = ON;
            end
        end
    endcase
end

// Define the output
always @* begin
    if (current_state == OFF) begin
        out = 1'b0;
    end else begin
        out = 1'b1;
    end
end

endmodule
