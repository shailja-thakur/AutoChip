module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);
    
    always @(*) begin
        // Default outputs
        Y1 = 0;
        Y3 = 0;
        
        // Determine Y1: the input of state flip-flop y[1] (state B)
        if (y[0]) begin // If current state is A
            if (w) Y1 = 1; // A --1--> B
        end else if (y[2]) begin // If current state is C
            if (!w) Y1 = 1; // C --0--> D
        end else if (y[3]) begin // If current state is D
            if (!w) Y1 = 1; // D --0--> A
        end else if (y[4]) begin // If current state is E
            if (!w) Y1 = 1; // E --0--> D
        end else if (y[5]) begin // If current state is F
            if (!w) Y1 = 1; // F --0--> D
        end
        
        // Determine Y3: the input of state flip-flop y[3] (state D)
        if (y[1]) begin // If current state is B
            if (!w) Y3 = 1; // B --0--> D
        end else if (y[2]) begin // If current state is C
            if (!w) Y3 = 1; // C --0--> D
        end else if (y[3]) begin // If current state is D
            if (!w) Y3 = 1; // D --0--> A
        end else if (y[4]) begin // If current state is E
            if (!w) Y3 = 1; // E --0--> D
        end else if (y[5]) begin // If current state is F
            if (!w) Y3 = 1; // F --0--> D
        end
    end

endmodule
