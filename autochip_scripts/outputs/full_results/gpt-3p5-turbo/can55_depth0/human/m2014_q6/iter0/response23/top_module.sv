module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Declare state signal
    reg [2:0] state;

    // Declare next state and output signals
    reg [2:0] next_state;
    wire [2:0] state_out;

    // Assign initial state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    // Assign next state and output based on current state and input
    always @(state or w) begin
        case (state)
            3'b000: begin
                if (w)
                    next_state = 3'b000;
                else
                    next_state = 3'b001;
                z = 0;
            end
            3'b001: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b011;
                z = 0;
            end
            3'b010: begin
                if (w)
                    next_state = 3'b110;
                else
                    next_state = 3'b011;
                z = 0;
            end
            3'b011: begin
                if (w)
                    next_state = 3'b000;
                else
                    next_state = 3'b010;
                z = 0;
            end
            3'b100: begin
                if (w)
                    next_state = 3'b100;
                else
                    next_state = 3'b011;
                z = 1;
            end
            3'b101: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b011;
                z = 1;
            end
            3'b110: begin
                if (w)
                    next_state = 3'b100;
                else
                    next_state = 3'b011;
                z = 1;
            end
            3'b111: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b011;
                z = 1;
            end
            default: begin
                next_state = 0;
                z = 0;
            end
        endcase
    end
endmodule
