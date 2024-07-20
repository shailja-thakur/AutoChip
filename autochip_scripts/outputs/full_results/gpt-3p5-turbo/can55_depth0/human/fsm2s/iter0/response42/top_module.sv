module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    localparam OFF = 0;
    localparam ON = 1;
    reg [1:0] state, next_state;
    
    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
        endcase
    end
    
    // Output assignment
    always @(state) begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
        endcase
    end

endmodule
