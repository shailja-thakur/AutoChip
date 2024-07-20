module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the state enumeration
localparam [1:0] IDLE = 2'b00, ONE = 2'b01, ERROR = 2'b10, DISC = 2'b11;

// State register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = ONE;
            end else begin
                next_state = IDLE;
            end
        end
        ONE: begin
            if (in == 1'b1) begin
                next_state = ONE;
            end else begin
                next_state = IDLE;
            end
        end
        ERROR: begin
            next_state = IDLE;
        end
        DISC: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        DISC: begin
            disc = 1'b1;
        end
        ERROR: begin
            err = 1'b1;
        end
        ONE: begin
            if (in == 1'b0) begin
                flag = 1'b1;
            end
        end
        default: begin
            // Do nothing
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

endmodule
