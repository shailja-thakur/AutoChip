module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg z;
reg [1:0] state;
reg [1:0] next_state;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Moore state transition and output logic
always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        // Asynchronous reset, initialize to starting state S0
        state <= S0;
    end else begin
        // State transition logic
        case(state)
            S0: begin
                if (x == 1) begin
                    next_state <= S1;
                end else begin
                    next_state <= S0;
                end
                z <= 0; // Output is 0 in state S0
            end
            S1: begin
                if (x == 0) begin
                    next_state <= S2;
                end else begin
                    next_state <= S1;
                end
                z <= 1; // Output is 1 in state S1
            end
            S2: begin
                if (x == 0) begin
                    next_state <= S2;
                end else begin
                    next_state <= S1;
                end
                z <= 0; // Output is 0 in state S2
            end
        endcase
    end
end

// Sequential state assignment
always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

endmodule
