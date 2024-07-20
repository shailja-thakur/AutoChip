module top_module(
    input x,
    input y,
    output z);
    
    // Declare internal signals
    reg [1:0] state;
    wire [1:0] next_state;
    
    // Assign next state logic
    always @(x, y, state) begin
        case (state)
            2'b00: begin // state 0
                if (x & !y)
                    next_state = 2'b10;
                else if (!x & y)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b01: begin // state 1
                next_state = 2'b00;
            end
            2'b10: begin // state 2
                next_state = 2'b11;
            end
            2'b11: begin // state 3
                next_state = 2'b10;
            end
        endcase
    end
    
    // Assign output logic
    always @(state) begin
        case (state)
            2'b00: begin // state 0
                z = 1'b1;
            end
            2'b01: begin // state 1
                z = 1'b0;
            end
            2'b10: begin // state 2
                z = 1'b0;
            end
            2'b11: begin // state 3
                z = 1'b1;
            end
        endcase
    end
    
    // Assign current state
    always @(posedge clk) begin
        state <= next_state;
    end
    
endmodule
